<style>
    .bluepayment img {
        margin-bottom: 10px;
    }
</style>

<div class="row bluepayment">
    <div class="col-md-10 col-md-offset-1">
        <h4><?php echo $text_information_redirect; ?></h4>
        <img src="catalog/view/theme/default/image/bluepayment_banner.png" class="img-responsive"/>
        <span><?php echo $text_information_payment_regulations; ?></span>
    </div>
</div>
<div class="buttons">
    <div class="pull-right">
        <input type="button" value="<?php echo $text_button_checkout ?>" class="btn btn-primary js-bluepayment-confirm" />
    </div>
</div>
<script type="text/javascript">
    $('.js-bluepayment-confirm').on('click', function() {
        let buttonEl = this;
        let url = '<?php echo $start_transaction_uri; ?>';

        let data = {};

        <?php if (isset($gateway_id)): ?>
            data['gateway_id'] = '<?php echo $gateway_id ?>';
        <?php endif; ?>

        $.ajax({
            url: url,
            data: data,
            method: 'POST',
            dataType: 'json',
            beforeSend: function() {
                $(buttonEl).button('loading');
            },
            complete: function() {
                $(buttonEl).button('reset');
            },
            success: function(response) {
                if (response.redirect) {
                    window.location.href = response.redirect;
                } else {
                    alert('Unable to redirect. Try again later.');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
</script>
