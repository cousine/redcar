
module Redcar
  class EditViewPlugin < Redcar::Plugin
    def self.load(plugin) #:nodoc:
      Redcar::EditView::Indenter.lookup_indent_rules
      Redcar::EditView::AutoPairer.lookup_autopair_rules

      plugin.transition(FreeBASE::LOADED)
    end

    def self.start(plugin) #:nodoc:
      Redcar::EditView::SnippetInserter.load_snippets

      plugin.transition(FreeBASE::RUNNING)
    end

    def self.stop(plugin) #:nodoc:
#       Redcar::EditView::Theme.cache
      plugin.transition(FreeBASE::LOADED)
    end
  end  
end

load File.dirname(__FILE__) + "/lib/edit_view.rb"
Dir[File.dirname(__FILE__) + "/lib/*"].each {|f| load f}
load File.dirname(__FILE__) + "/commands/snippet_command.rb"
Dir[File.dirname(__FILE__) + "/commands/*"].each {|f| load f}