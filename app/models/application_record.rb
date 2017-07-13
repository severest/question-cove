class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  @@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, autolink: true)
end
