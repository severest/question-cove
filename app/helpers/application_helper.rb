module ApplicationHelper
  def voteup(path)
    return link_to raw('<span class="glyphicon glyphicon-chevron-up" aria-hidden="true"></span>'), path, method: :post
  end

  def votedown(path)
    return link_to raw('<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>'), path, method: :post
  end
end
