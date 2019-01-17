$(document).ready(function(){

  $("#filter").change(function(){
   $.ajax({
    url: '/search',
    type: 'GET',
    dataType: 'script',
    data: {filter: this.value},
      success: function(repsonse){},
		});
  });

  $("#rating_filter").change(function(){
  $.ajax({
    url: '/search',
    type: 'GET',
    dataType: 'script',
    data: {ratingfilter: this.value} ,
      success: function(repsonse){console.log(repsonse)}
		});
  });


  $(".check_tagging").change(function(){
      var dishes = [];
      $(':checkbox:checked').each(function(i){
        dishes[i] = $(this).attr("id");
    });
      console.log(dishes)
      $.ajax({
      url: '/search',
      type: 'GET',
      dataType: 'script',
      data: {taggingfilter: dishes},
        success: function(repsonse){}
    });
  });

  var slider = $("#slider").slider({
      range: true,
      min: 10,
      max: 1000,
      values: [100, 900],
      slide: function(event, ui) {
        $("#range_min").val(ui.values[0]);
        $("#range_max").val(ui.values[1]);
        var dishes_range_min = ui.values[0];
        var dishes_range_max = ui.values[1];
        console.log(dishes_range_min, dishes_range_max)
        $.ajax({
          url: '/search',
          type: 'GET',
          dataType: 'script',
          data: {min_rangefilter: dishes_range_min, max_rangefilter: dishes_range_max },
            success: function(repsonse){}
        });
      }
    });
});
