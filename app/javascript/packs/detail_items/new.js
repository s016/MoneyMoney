$(function () {
  $("#detail_item_income_or_payment_1").click(function () {
    $.get({
      url: "/detail_items/select_incomes",
    });
  });

  $("#detail_item_income_or_payment_2").click(function () {
    $.get({
      url: "/detail_items/select_payments",
    });
  });
});