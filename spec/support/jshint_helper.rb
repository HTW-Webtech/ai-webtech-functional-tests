require 'jshintrb'

module JSHintHelper
  def lint(source)
    source = source.force_encoding('ASCII-8BIT').encode('UTF-8', undef: :replace, replace: '')
    Jshintrb::Lint.new(lint_options).lint(source)
  end

  def lint_options
    {
      # Enforcing
      # esversion: 5,
      # es5: true, # Already set by default
      eqeqeq: true,
      latedef: true,
      freeze: true,
      maxerr: 100,
      # Env
      browser: true,
    }
  end
end
