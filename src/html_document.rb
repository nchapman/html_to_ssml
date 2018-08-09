require 'rails-html-sanitizer'
require 'readability'

class HtmlDocument
  SAFE_TAGS = %w(div p strong b em i ol ul li h1 h2 h3 h4 h5 blockquote)
  SAFE_ATTRIBUTES = %w()

  def initialize(html_string)
    @html_string = html_string

  end

  def to_ssml
    transform(wrap_html(annotate(sanitize(extract_content))))
  end

  def extract_content
    content = Readability::Document.new(@html_string, tags: SAFE_TAGS).content.to_s
  end

  def wrap_html(html_string)
    <<~HEREDOC
    <!doctype html>
    <html>
      <head>
         <meta charset="utf-8">
      </head>
      <body>
        #{html_string}
      </body>
    </html>
    HEREDOC
  end

  def sanitize(html_string)
    white_list_sanitizer = Rails::Html::WhiteListSanitizer.new
    white_list_sanitizer.sanitize(html_string, tags: SAFE_TAGS, attributes: SAFE_ATTRIBUTES)
  end

  def annotate(html_string)
    # TODO: might make sense to normalize characters before replacing
    annotated_html = html_string.gsub(/([“"]+.*?[”"]+)/, %q{<span class="quote">\1</span>})

    annotated_html
  end

  def transform(html_string)
    html = Nokogiri::HTML(html_string)
    xslt = Nokogiri::XSLT(File.read('./xslt/default.xslt'))

    xslt.transform(html)
  end
end
