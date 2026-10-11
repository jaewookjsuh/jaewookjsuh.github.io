# frozen_string_literal: true

require "bundler/setup"
require "fileutils"
require "minitest/autorun"
require "tmpdir"

require "jekyll"

class JekyllRenderTest < Minitest::Test
  def test_real_renderer_sees_default_and_custom_liquid_tags
    source = Dir.mktmpdir("jekyll-render-source")
    destination = Dir.mktmpdir("jekyll-render-destination")

    FileUtils.mkdir_p(File.join(source, "_plugins"))
    FileUtils.mkdir_p(File.join(source, "_layouts"))
    FileUtils.cp(
      File.expand_path("../_plugins/markdown.rb", __dir__),
      File.join(source, "_plugins", "markdown.rb")
    )

    File.write(File.join(source, "_config.yml"), "markdown: kramdown\n")
    File.write(File.join(source, "_layouts", "default.html"), "{{ content }}")
    File.write(
      File.join(source, "index.html"),
      <<~HTML
        ---
        layout: default
        ---
        {% if true %}if-ok{% endif %}
        {% markdown %}**markdown-ok**{% endmarkdown %}
      HTML
    )

    site = Jekyll::Site.new(
      Jekyll.configuration(
        "source" => source,
        "destination" => destination,
        "disable_disk_cache" => true,
        "quiet" => true
      )
    )

    site.process

    output = File.read(File.join(destination, "index.html"))
    assert_includes output, "if-ok"
    assert_includes output, "<strong>markdown-ok</strong>"
  ensure
    FileUtils.remove_entry(source) if source && Dir.exist?(source)
    FileUtils.remove_entry(destination) if destination && Dir.exist?(destination)
  end
end
