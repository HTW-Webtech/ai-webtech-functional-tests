module PoltergeistHelper
  def clear_storage
    page.execute_script 'if (localStorage && localStorage.clear) localStorage.clear();'
    page.execute_script 'if (sessionStorage && sessionStorage.clear) sessionStorage.clear();'
  end
end
