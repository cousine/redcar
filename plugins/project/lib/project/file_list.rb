module Redcar
  class Project
    class FileList
      attr_reader :path
    
      def initialize(path)
        @path = File.expand_path(path)
        @files = {}
      end
      
      def all_files
        @files.keys
      end
      
      def update
        new_files = {}
        find(path) do |file_path|
          throw :prune if file_path =~ /\.git|\.yardoc|\.svn/
          next if file_path == ""
          begin
            stat = File.lstat(file_path)
            next if stat.directory?
            new_files[file_path] = stat.mtime
          rescue Errno::ENOENT, Errno::EACCES
          end
        end
        added_files    = get_added_files(@files, new_files)
        modified_files = get_modified_files(@files, new_files)
        deleted_files  = get_deleted_files(@files, new_files)
        @files = new_files
        [added_files, modified_files, deleted_files]
      end
      
      private
      
      def get_added_files(from, to)
        to.keys - from.keys
      end
      
      def get_deleted_files(from, to)
        from.keys - to.keys
      end
      
      def get_modified_files(from, to)
        result = []
        from.each do |file, mtime|
          if new_mtime = to[file] and new_mtime > mtime
            result << file
          end
        end
        result
      end
      
      def find(*paths)
        paths.collect!{|d| d.dup}
        while file = paths.shift
          catch(:prune) do
            yield file.dup.taint
            next unless File.exist? file
            begin
              if File.lstat(file).directory? then
                d = Dir.open(file)
                begin
                  for f in d
                    next if f == "." or f == ".."
                    if File::ALT_SEPARATOR and file =~ /^(?:[\/\\]|[A-Za-z]:[\/\\]?)$/ then
                      f = file + f
                    elsif file == "/" then
                      f = "/" + f
                    else
                      f = File.join(file, f)
                    end
                    paths.unshift f.untaint
                  end
                ensure
                  d.close
                end
              end
            rescue Errno::ENOENT, Errno::EACCES
            end
          end
        end
      end
    end
  end
end