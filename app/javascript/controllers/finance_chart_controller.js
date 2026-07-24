import { Controller } from "@hotwired/stimulus"
import Chart from "chart.js/auto"

export default class extends Controller {
  static values = {
    labels: Array,
    income: Array,
    expense: Array,
    categories: Array
  }

  connect() {
    if (this.hasCategoriesValue) {
      this.renderCategoryChart()
    } else {
      this.renderCashflowChart()
    }
  }

  disconnect() {
    this.chart?.destroy()
  }

  renderCashflowChart() {
    this.chart = new Chart(this.element, {
      type: "line",
      data: {
        labels: this.labelsValue,
        datasets: [
          { label: "Receitas", data: this.incomeValue, borderColor: "#16a34a", backgroundColor: "rgba(22, 163, 74, .12)", tension: .35, fill: true },
          { label: "Despesas", data: this.expenseValue, borderColor: "#dc2626", backgroundColor: "rgba(220, 38, 38, .10)", tension: .35, fill: true }
        ]
      },
      options: { responsive: true, maintainAspectRatio: false }
    })
  }

  renderCategoryChart() {
    this.chart = new Chart(this.element, {
      type: "doughnut",
      data: {
        labels: this.categoriesValue.map((item) => item.name),
        datasets: [{ data: this.categoriesValue.map((item) => item.amount), backgroundColor: this.categoriesValue.map((item) => item.color) }]
      },
      options: { responsive: true, maintainAspectRatio: false, cutout: "68%" }
    })
  }
}
