module PoltergeistHelper
  def clear_local_storage
    page.execute_script 'localStorage.clear();'
  end
end
