$(function () {
  $("#income_and_payment_item_id").change(function () {
    $.get({
      url: "/income_and_payments/select_item",
      data: { item_id: $("#income_and_payment_item_id").has("option:selected").val() }
    });
  });

  $("#income_and_payment_income_or_payment_1").click(function () {
    $.get({
      url: "/income_and_payments/select_incomes",
    });
  });

  $("#income_and_payment_income_or_payment_2").click(function () {
    $.get({
      url: "/income_and_payments/select_payments",
    });
  });
});