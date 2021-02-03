require  "fileutils"
require  "erb"
require  "json"
require  "time"
require  "date"
require_relative "deeply"

module App
  module Config
    using Deeply

    class JSON < ::Hash
      include App::Config::Base

      DEFAULT_MASK  =  "*.json"
      DEFAULT_SUFFIX  =  ".json"
      DEFAULT_ENCODE  =  { allow_nan: true }
      DEFAULT_DECODE  =  { allow_nan: true }

      def initialize( **opts )
        super()
        reload( **opts )
      end

      # bulk load configuration in search paths.
      def reload( root: nil, path: nil, encode: nil, decode: nil )
        clear
        @root  =  root || Dir.pwd
        @paths  =  ( path || DEFAULT_PATH ).gsub('$ROOT', @root).split(':')
        @paths  =  @paths.map{|it| !it.nil? && !it.empty? ? it : nil}.compact
        @paths  <<  "."    if @paths.empty?

        @vardir  =  @paths.last
        Dir.mkdir( @vardir )    unless ::Dir.exist?( @vardir )

        @encode  =  DEFAULT_ENCODE.merge( encode || {} )
        @decode  =  DEFAULT_DECODE.merge( decode || {} )

        load_overlay( DEFAULT_MASK )
      end

      # load configuration.
      def load( section )
        raise  ArgumentError, "'#{ section }' is not String."    unless  String === section

        self[section].clear
        load_overlay( section + DEFAULT_SUFFIX )
      end

      # load configuration.
      def load_overlay( filename )
        @paths.each do |path|
          begin
            dirname  =  ::File.expand_path( path )
            if  ::Dir.exist?( dirname )
              ::Dir.glob( "#{ dirname }/#{ filename }" ) do |pathname|
                text  =  ::File.open( pathname ).read    rescue  raise( ArgumentError, "could not load #{ pathname }" )
                json  =  ::ERB.new( text ).result        rescue  raise( ArgumentError, "could not parse by ERB: #{ pathname }" )
                hash  =  ::JSON.load( json, **@decode )
                self.deeply_merge!( hash )
              end
            end
          rescue => e
            STDERR.puts e.message
          end
        end
      end

      # save configuration.
      def save( section )
        raise  ArgumentError, "'#{ section }' is not String."    unless  String === section
        pathname  =  savepathname(section)
        hash  =  { section => self[section] }.deeply_stringify_keys
        ::File.open( pathname, "w" ) do |file|
          file.puts( ::JSON.pretty_generate( hash, **@encode ) )
        end
      end

      # remove and load configuration.
      def reset( section )
        raise  ArgumentError, "'#{ section }' is not String."    unless  String === section

        pathname  =  savepathname(section)
        ::FileUtils.remove( pathname )    if ::File.exist?( pathname )
        load( section )
      end

      def savepathname( section )
        ::File.join( @vardir, section + DEFAULT_SUFFIX )
      end

    end
  end
end

