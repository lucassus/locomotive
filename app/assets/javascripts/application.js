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
    Recurly.buildSubscriptionForm({
      target: '#' + $recurlySubsctiptionForm.attr('id'),
      planCode: $recurlySubsctiptionForm.data('plan-code'),
      successURL: $recurlySubsctiptionForm.data('success-url'),
      signature: $recurlySubsctiptionForm.data('signature'),

      accountCode: $recurlySubsctiptionForm.data('account-code'),
      account: {
        email: $recurlySubsctiptionForm.data('account-email')
      }
    });
  }

  var $recurlyBillingInfoForm = $('#recurly-billing-info-form');
  if ($recurlyBillingInfoForm.length > 0) {
    Recurly.buildBillingInfoUpdateForm({
      target: '#' + $recurlyBillingInfoForm.attr('id'),
      successURL: $recurlyBillingInfoForm.data('success-url'),
      accountCode: $recurlyBillingInfoForm.data('account-code'),
      signature: $recurlyBillingInfoForm.data('signature')
    });
  }

});
