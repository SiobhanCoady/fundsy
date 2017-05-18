$(document).ready(function() {
  $('#cc-form').on('submit', function(event) {
    event.preventDefault();

    // This will make an AJAX request to the Stripe server with the credit card
    // information. When we receive a response back from the Stripe server,
    // then the callback function 'stripeResponseHandler' will be called.
    Stripe.card.createToken({
      number: $('#card_number').val(),
      cvc: $('#cvc').val(),
      exp_month: $('#date_month').val(),
      exp_year: $('#date_year').val()
    }, stripeResponseHandler);

  });

  function stripeResponseHandler(status, response) {

    if (status === 200) {
      // response.id is the Stripe Token (the one-time use token)
      $('#stripe_token').val(response.id);
      $('#server-form').submit();
    } else {
      // This will remove the attribute 'disabled' from the submit button, which
      // means the button will be enabled again
      $('[type=submit]').removeAttr('disabled');
      $('#stripe-error').html(response.error.message);
    }


    console.log(status);
    console.log(response);
  }

});
