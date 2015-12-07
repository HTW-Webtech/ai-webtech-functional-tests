module PoltergeistHelper
  def clear_local_storage
    page.execute_script('if (localStorage && localStorage.clear) localStorage.clear();')
  end
end
