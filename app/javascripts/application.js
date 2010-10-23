//= require <jquery-1.4.2.min>
//= require <jquery-ui-1.8.5.custom.min>
//= require <radiator>
//= require <fail>

jQuery(document).ready(function($) {
  radiator.animateFails();
  radiator.updatePeriodically();

  fail.toggleExpanded();

  // TODO: Update next & previous on occurence collection when new occurence comes in

  // TODO: Loading of occurences from next and previous links

  // TODO: Showing resolved on/off

  // TODO: Marking fail as resolved

  // TODO: Collapsing other fails when new is expanded

  // TODO: Project fail count
});
