//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require recurly
//= require_tree .

$(function() {

  Recurly.config({
    subdomain: 'lukasz-bandzarewicz',
    currency: 'GBP',
    country: 'PL'
  });

  // Initialize recurly form
  var $recurlySubsctiptionForm = $('#recurly-subscription-form');
  if ($recurlySubsctiptionForm.length > 0) {
    var options = $recurlySubsctiptionForm.data('options');

    Recurly.buildSubscriptionForm({
      target: '#' + $recurlySubsctiptionForm.attr('id'),
      planCode: options.planCode,
      successURL: options.successURL,
      signature: options.signature,

      accountCode: options.account.code,
      account: {
        email: options.account.email
      }
    });
  }

  var $recurlyBillingInfoForm = $('#recurly-billing-info-form');
  if ($recurlyBillingInfoForm.length > 0) {
    var options = $recurlyBillingInfoForm.data('options');

    Recurly.buildBillingInfoUpdateForm({
      target: '#' + $recurlyBillingInfoForm.attr('id'),
      successURL: options.successURL,
      signature: options.signature,
      accountCode: options.account.code
    });
  }

});
