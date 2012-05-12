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
      accountCode: options.account.code,
      billingInfo: {
        firstName: options.billingInfo.firstName,
        lastName: options.billingInfo.lastName,
        address1: options.billingInfo.address1,
        address2: options.billingInfo.address2,
        country: options.billingInfo.country,
        city: options.billingInfo.city,
        state: options.billingInfo.state,
        zip: options.billingInfo.zip
      },
      afterInject: function() {
        var lastFour = options.billingInfo.lastFour;
        $('.field.card_number .placeholder').text('xxxx-xxxx-xxxx-' + lastFour);
      }
    });
  }

});
