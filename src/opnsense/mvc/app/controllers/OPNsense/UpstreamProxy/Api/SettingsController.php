<?php
namespace OPNsense\UpstreamProxy\Api;

use \OPNsense\Base\ApiControllerBase;
use \OPNsense\Core\Config;
use \OPNsense\UpstreamProxy\UpstreamProxy;

class SettingsController extends ApiControllerBase
{
    /* retrieve UpstreamProxy general settings
     * @return array general settings
     */
    public function getAction()
    {
        // define list of configurable settings
        $result = array();
        if ($this->request->isGet()) {
            $mdlUpstreamProxy = new UpstreamProxy();
            $result['upstreamproxy'] = $mdlUpstreamProxy->getNodes();
        }
        return $result;
    }

    /**
     * update UpstreamProxy settings
     * @return array status
     */
    public function setAction()
    {
        $result = array("result"=>"failed");
        if ($this->request->isPost()) {
            // load model and update with provided data
            $mdlUpstreamProxy = new UpstreamProxy();
            $mdlUpstreamProxy->setNodes($this->request->getPost("upstreamproxy"));
    
            // perform validation
            $valMsgs = $mdlUpstreamProxy->performValidation();
            foreach ($valMsgs as $field => $msg) {
                if (!array_key_exists("validations", $result)) {
                    $result["validations"] = array();
                }
                $result["validations"]["general.".$msg->getField()] = $msg->getMessage();
            }
    
            // serialize model to config and save
            if ($valMsgs->count() == 0) {
                $mdlUpstreamProxy->serializeToConfig();
                Config::getInstance()->save();
                $result["result"] = "saved";
            }
        }
        return $result;
    }

}

?>
