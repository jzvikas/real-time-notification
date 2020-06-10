<?php $placement = explode('-', $real_time_notification_position); ?>

<script type="text/javascript">
function showNotifications(){
	$.get("index.php?route=extension/module/real_time_notification/notification", function(data){
		if(typeof data !== "undefined") {
			if(typeof data['sales'] !== "undefined") {
				$.each(data['sales'], function(i, v) {
					setTimeout(function(){
						$.notify({
							icon: v.thumb,
							url: v.href,
							// title: v.message,
							message: v.message,
						}, {
							placement: {
								from: '<?php echo $placement[0]; ?>',
								align: '<?php echo $placement[1]; ?>'
							},
							type: 'notification',
							allow_dismiss: "<?php echo $real_time_notification_allow_dismiss; ?>",
							mouse_over: "<?php echo $real_time_notification_pause_on_hover? 'pause' : 'null'; ?>",
							delay: "<?php echo $real_time_notification_delay; ?>",
							newest_on_top: "<?php echo $real_time_notification_newest_on_top; ?>",
							showProgressbar: "<?php echo $real_time_notification_progress_bar; ?>",
							spacing: 20,
							icon_type: 'image',
							template: '<div data-notify="container" class="alert alert-{0}" role="alert">' +
								'<div class="inner-container">' +
									<?php if($real_time_notification_allow_dismiss) { ?>
									'<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
									<?php } ?>
									'<div class="img-block">' +
										'<a href="{3}" target="_blank">' +
											'<img data-notify="icon" class="img-circle">' +
										'</a>' +
									'</div>' +
									'<div class="content-block">' +
										// '<span data-notify="title">{1}</span>' +
										'<span data-notify="message">{2}</span>' +
									'</div>' +
									'<div class="clearfix"></div>' +
									<?php if($real_time_notification_progress_bar) { ?>
									'<div class="progress" data-notify="progressbar">' +
										'<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
									'</div>' +
									<?php } ?>
								'</div>' +
							'</div>'
						});
					}, 2000 * i);
				});
			}
		}
	});
}

function pullNotifications(){
	setInterval(showNotifications, <?php echo $real_time_notification_interval; ?>);
}
$(document).ready(function(){
	pullNotifications();
});
</script>