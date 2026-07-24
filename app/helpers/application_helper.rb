module ApplicationHelper
  def money(value)
    number_to_currency(value || 0, unit: "R$ ", separator: ",", delimiter: ".")
  end

  def kind_badge(kind)
    klass = kind == "income" ? "text-bg-success" : "text-bg-danger"
    label = kind == "income" ? "Receita" : "Despesa"
    tag.span(label, class: "badge #{klass}")
  end

  def status_badge(status)
    labels = {
      "pending" => ["Pendente", "text-bg-warning"],
      "paid" => ["Pago", "text-bg-success"],
      "overdue" => ["Atrasado", "text-bg-danger"],
      "canceled" => ["Cancelado", "text-bg-secondary"]
    }
    label, klass = labels.fetch(status, [status.to_s.humanize, "text-bg-light"])
    tag.span(label, class: "badge #{klass}")
  end
end
