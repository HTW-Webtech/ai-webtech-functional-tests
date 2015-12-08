module PoltergeistHelper
  def clear_storage_and_reload
    page.execute_script 'if (localStorage && localStorage.clear) localStorage.clear();'
    page.execute_script 'if (sessionStorage && sessionStorage.clear) sessionStorage.clear();'
    page.execute_script 'window.location.reload();'
  end
end
