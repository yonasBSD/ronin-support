# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ronin-ext}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Postmodern"]
  s.date = %q{2010-04-03}
  s.description = %q{Ronin EXT is a support library for Ronin. Ronin EXT contains many of the convenience methods used by Ronin and additional libraries.}
  s.email = %q{postmodern.mod3@gmail.com}
  s.extra_rdoc_files = [
    "ChangeLog.md",
    "README.md"
  ]
  s.files = [
    ".gitignore",
    ".specopts",
    ".yardopts",
    "COPYING.txt",
    "ChangeLog.md",
    "README.md",
    "Rakefile",
    "lib/ronin/ext.rb",
    "lib/ronin/ext/version.rb",
    "lib/ronin/extensions.rb",
    "lib/ronin/extensions/array.rb",
    "lib/ronin/extensions/file.rb",
    "lib/ronin/extensions/ip_addr.rb",
    "lib/ronin/extensions/kernel.rb",
    "lib/ronin/extensions/meta.rb",
    "lib/ronin/extensions/meta/object.rb",
    "lib/ronin/extensions/string.rb",
    "lib/ronin/extensions/uri.rb",
    "lib/ronin/extensions/uri/http.rb",
    "lib/ronin/extensions/uri/query_params.rb",
    "lib/ronin/formatting.rb",
    "lib/ronin/formatting/binary.rb",
    "lib/ronin/formatting/digest.rb",
    "lib/ronin/formatting/extensions.rb",
    "lib/ronin/formatting/extensions/binary.rb",
    "lib/ronin/formatting/extensions/binary/file.rb",
    "lib/ronin/formatting/extensions/binary/integer.rb",
    "lib/ronin/formatting/extensions/binary/string.rb",
    "lib/ronin/formatting/extensions/digest.rb",
    "lib/ronin/formatting/extensions/digest/string.rb",
    "lib/ronin/formatting/extensions/http.rb",
    "lib/ronin/formatting/extensions/http/string.rb",
    "lib/ronin/formatting/extensions/text.rb",
    "lib/ronin/formatting/extensions/text/array.rb",
    "lib/ronin/formatting/extensions/text/string.rb",
    "lib/ronin/formatting/http.rb",
    "lib/ronin/formatting/text.rb",
    "lib/ronin/network.rb",
    "lib/ronin/network/esmtp.rb",
    "lib/ronin/network/extensions.rb",
    "lib/ronin/network/extensions/esmtp.rb",
    "lib/ronin/network/extensions/esmtp/net.rb",
    "lib/ronin/network/extensions/http.rb",
    "lib/ronin/network/extensions/http/net.rb",
    "lib/ronin/network/extensions/imap.rb",
    "lib/ronin/network/extensions/imap/net.rb",
    "lib/ronin/network/extensions/pop3.rb",
    "lib/ronin/network/extensions/pop3/net.rb",
    "lib/ronin/network/extensions/smtp.rb",
    "lib/ronin/network/extensions/smtp/net.rb",
    "lib/ronin/network/extensions/ssl.rb",
    "lib/ronin/network/extensions/ssl/io.rb",
    "lib/ronin/network/extensions/tcp.rb",
    "lib/ronin/network/extensions/tcp/net.rb",
    "lib/ronin/network/extensions/telnet.rb",
    "lib/ronin/network/extensions/telnet/net.rb",
    "lib/ronin/network/extensions/udp.rb",
    "lib/ronin/network/extensions/udp/net.rb",
    "lib/ronin/network/http.rb",
    "lib/ronin/network/http/exceptions.rb",
    "lib/ronin/network/http/exceptions/unknown_request.rb",
    "lib/ronin/network/http/http.rb",
    "lib/ronin/network/http/proxy.rb",
    "lib/ronin/network/imap.rb",
    "lib/ronin/network/mixins.rb",
    "lib/ronin/network/mixins/esmtp.rb",
    "lib/ronin/network/mixins/http.rb",
    "lib/ronin/network/mixins/imap.rb",
    "lib/ronin/network/mixins/pop3.rb",
    "lib/ronin/network/mixins/smtp.rb",
    "lib/ronin/network/mixins/tcp.rb",
    "lib/ronin/network/mixins/telnet.rb",
    "lib/ronin/network/mixins/udp.rb",
    "lib/ronin/network/pop3.rb",
    "lib/ronin/network/smtp.rb",
    "lib/ronin/network/smtp/email.rb",
    "lib/ronin/network/smtp/smtp.rb",
    "lib/ronin/network/ssl.rb",
    "lib/ronin/network/tcp.rb",
    "lib/ronin/network/telnet.rb",
    "lib/ronin/network/udp.rb",
    "lib/ronin/path.rb",
    "lib/ronin/scanner.rb",
    "lib/ronin/scanner/class_methods.rb",
    "lib/ronin/scanner/exceptions.rb",
    "lib/ronin/scanner/exceptions/unknown_category.rb",
    "lib/ronin/scanner/extensions.rb",
    "lib/ronin/scanner/extensions/ip_addr.rb",
    "lib/ronin/scanner/extensions/uri.rb",
    "lib/ronin/scanner/extensions/uri/http.rb",
    "lib/ronin/scanner/scanner.rb",
    "lib/ronin/templates.rb",
    "lib/ronin/templates/erb.rb",
    "lib/ronin/templates/template.rb",
    "lib/ronin/yard.rb",
    "lib/ronin/yard/extensions.rb",
    "lib/ronin/yard/legacy.rb",
    "lib/ronin/yard/legacy/scanner_handler.rb",
    "lib/ronin/yard/scanner_handler.rb",
    "ronin-ext.gemspec",
    "spec/ext_spec.rb",
    "spec/extensions/array_spec.rb",
    "spec/extensions/ip_addr_spec.rb",
    "spec/extensions/kernel_spec.rb",
    "spec/extensions/string_spec.rb",
    "spec/extensions/uri/http_spec.rb",
    "spec/extensions/uri/query_params_spec.rb",
    "spec/formatting/binary/helpers/hexdumps.rb",
    "spec/formatting/binary/helpers/hexdumps/ascii.bin",
    "spec/formatting/binary/helpers/hexdumps/hexdump_decimal_shorts.txt",
    "spec/formatting/binary/helpers/hexdumps/hexdump_hex_bytes.txt",
    "spec/formatting/binary/helpers/hexdumps/hexdump_hex_shorts.txt",
    "spec/formatting/binary/helpers/hexdumps/hexdump_octal_bytes.txt",
    "spec/formatting/binary/helpers/hexdumps/hexdump_octal_shorts.txt",
    "spec/formatting/binary/helpers/hexdumps/hexdump_repeated.txt",
    "spec/formatting/binary/helpers/hexdumps/od_decimal_bytes.txt",
    "spec/formatting/binary/helpers/hexdumps/od_decimal_ints.txt",
    "spec/formatting/binary/helpers/hexdumps/od_decimal_quads.txt",
    "spec/formatting/binary/helpers/hexdumps/od_decimal_shorts.txt",
    "spec/formatting/binary/helpers/hexdumps/od_hex_bytes.txt",
    "spec/formatting/binary/helpers/hexdumps/od_hex_ints.txt",
    "spec/formatting/binary/helpers/hexdumps/od_hex_quads.txt",
    "spec/formatting/binary/helpers/hexdumps/od_hex_shorts.txt",
    "spec/formatting/binary/helpers/hexdumps/od_octal_bytes.txt",
    "spec/formatting/binary/helpers/hexdumps/od_octal_ints.txt",
    "spec/formatting/binary/helpers/hexdumps/od_octal_quads.txt",
    "spec/formatting/binary/helpers/hexdumps/od_octal_shorts.txt",
    "spec/formatting/binary/helpers/hexdumps/od_repeated.txt",
    "spec/formatting/binary/helpers/hexdumps/repeated.bin",
    "spec/formatting/binary/integer_spec.rb",
    "spec/formatting/binary/string_spec.rb",
    "spec/formatting/digest/string_spec.rb",
    "spec/formatting/http/string_spec.rb",
    "spec/formatting/text/array_spec.rb",
    "spec/formatting/text/string_spec.rb",
    "spec/network/http/http_spec.rb",
    "spec/network/http/proxy_spec.rb",
    "spec/path_spec.rb",
    "spec/scanner/classes/another_scanner.rb",
    "spec/scanner/classes/example_scanner.rb",
    "spec/scanner/extensions_spec.rb",
    "spec/scanner/scanner_spec.rb",
    "spec/spec_helper.rb",
    "spec/templates/classes/example_erb.rb",
    "spec/templates/classes/example_template.rb",
    "spec/templates/erb_spec.rb",
    "spec/templates/helpers/static.rb",
    "spec/templates/helpers/static/includes/_relative.erb",
    "spec/templates/helpers/static/templates/example.erb",
    "spec/templates/template_spec.rb"
  ]
  s.has_rdoc = %q{yard}
  s.homepage = %q{http://github.com/ronin-ruby/ronin-ext}
  s.licenses = ["LGPL-2.1"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A support library for Ronin.}
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/formatting/binary/integer_spec.rb",
    "spec/formatting/binary/string_spec.rb",
    "spec/formatting/binary/helpers/hexdumps.rb",
    "spec/formatting/digest/string_spec.rb",
    "spec/formatting/http/string_spec.rb",
    "spec/formatting/text/array_spec.rb",
    "spec/formatting/text/string_spec.rb",
    "spec/extensions/string_spec.rb",
    "spec/extensions/uri/http_spec.rb",
    "spec/extensions/uri/query_params_spec.rb",
    "spec/extensions/ip_addr_spec.rb",
    "spec/extensions/kernel_spec.rb",
    "spec/extensions/array_spec.rb",
    "spec/ext_spec.rb",
    "spec/path_spec.rb",
    "spec/templates/classes/example_erb.rb",
    "spec/templates/classes/example_template.rb",
    "spec/templates/erb_spec.rb",
    "spec/templates/helpers/static.rb",
    "spec/templates/template_spec.rb",
    "spec/scanner/classes/another_scanner.rb",
    "spec/scanner/classes/example_scanner.rb",
    "spec/scanner/scanner_spec.rb",
    "spec/scanner/extensions_spec.rb",
    "spec/network/http/http_spec.rb",
    "spec/network/http/proxy_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<chars>, ["~> 0.1.2"])
      s.add_runtime_dependency(%q<parameters>, ["~> 0.2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 1.3.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.5.3"])
      s.add_development_dependency(%q<yard-parameters>, ["~> 0.1.0"])
    else
      s.add_dependency(%q<chars>, ["~> 0.1.2"])
      s.add_dependency(%q<parameters>, ["~> 0.2.0"])
      s.add_dependency(%q<rspec>, ["~> 1.3.0"])
      s.add_dependency(%q<yard>, ["~> 0.5.3"])
      s.add_dependency(%q<yard-parameters>, ["~> 0.1.0"])
    end
  else
    s.add_dependency(%q<chars>, ["~> 0.1.2"])
    s.add_dependency(%q<parameters>, ["~> 0.2.0"])
    s.add_dependency(%q<rspec>, ["~> 1.3.0"])
    s.add_dependency(%q<yard>, ["~> 0.5.3"])
    s.add_dependency(%q<yard-parameters>, ["~> 0.1.0"])
  end
end

