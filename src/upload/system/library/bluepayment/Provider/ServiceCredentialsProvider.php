<?php

namespace BluePayment\Provider;

require_once DIR_SYSTEM . '/library/bluepayment/ValueObject/ServiceCredentials.php';

use Registry;
use bluepayment\ValueObject\ServiceCredentials;

final class ServiceCredentialsProvider
{
    private $registry;
    private $current_currency;

    public function __construct(Registry $registry)
    {
        $this->registry = $registry;
        $this->current_currency = $this->registry->get('session')->data['currency'];

        $this->registry->get('load')->model('setting/setting');
    }

    public function currencyServiceExists()
    {
        return isset($this->getAllServiceCredentials()[$this->current_currency]);
    }

    public function getCurrencyServiceCredentials($currency = '')
    {
        $service_credentials = $this->getAllServiceCredentials();

        if (!empty($currency)) {
            $this->current_currency = $currency;
        }

        return new ServiceCredentials(
            (int) $service_credentials[$this->current_currency]['service_id'],
            $service_credentials[$this->current_currency]['shared_key']
        );
    }

    public function getCurrentCurrency()
    {
        return $this->current_currency;
    }

    private function getAllServiceCredentials()
    {
        return json_decode(
            $this->registry->get('model_setting_setting')->getSettingValue('payment_bluepayment_currency')
        );
    }
}
