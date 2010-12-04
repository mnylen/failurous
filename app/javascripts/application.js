//= require <jquery-1.4.2.min>
//= require <jquery-ui-1.8.5.custom.min>
//= require <radiator>
//= require <fail>

jQuery(document).ready(function($) {
  radiator.animateFails();
  radiator.updatePeriodically();

  fail.toggleExpanded();
  fail.loadOccurencesUsingFailControls();
  fail.toggleShowResolved();
});
