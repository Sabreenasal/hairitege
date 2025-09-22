module BreadcrumbsHelper
  def render_breadcrumbs(items = [])
    return if items.blank?

    content_tag(:nav, aria: { label: "breadcrumb" },
      style: "--bs-breadcrumb-divider: url('data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'8\' height=\'8\'%3E%3Cpath d=\'M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z\' fill=\'currentColor\'/%3E%3C/svg%3E');") do
      content_tag(:ol, class: "breadcrumb") do
        safe_join(items.map.with_index do |(title, path), i|
          if i == items.size - 1 || path.nil?
            content_tag(:li, title, class: "breadcrumb-item active", "aria-current": "page")
          else
            content_tag(:li, link_to(title, path), class: "breadcrumb-item")
          end
        end)
      end
    end
  end
end
