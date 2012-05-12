//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require recurly
//= require_tree .

$(function() {

  // Initialize recurly form
  var $recurlyForm = $('#recurly-form');
  if ($recurlyForm.length > 0) {
    Recurly.config({
      subdomain: 'lukasz-bandzarewicz',
      currency: 'GBP',
      country: 'PL'
    });

    Recurly.buildSubscriptionForm({
      target: '#' + $recurlyForm.attr('id'),
      planCode: $recurlyForm.data('plan-code'),
      successURL: $recurlyForm.data('success-url'),
      signature: $recurlyForm.data('signature'),

      accountCode: $recurlyForm.data('account-code'),
      account: {
        email: $recurlyForm.data('account-email')
      }
    });
  }

});
