<?php
namespace OPNsense\UpstreamProxy\Api;

use \OPNsense\Base\ApiControllerBase;
use \OPNsense\Core\Backend;

class ServiceController extends ApiControllerBase
{

public function reloadAction()
{
    $status = "failed";
    if ($this->request->isPost()) {
        $backend = new Backend();
        $bckresult = trim($backend->configdRun("template reload OPNsense/UpstreamProxy"));
        if ($bckresult == "OK") {
            $status = "ok";
        }
    }
    return array("status" => $status);
}

public function applyAction()
{
    if ($this->request->isPost()) {
        $backend = new Backend();
        $bckresult = json_decode(trim($backend->configdRun("upstreamproxy apply")), true);
        if ($bckresult !== null) {
            // only return valid json type responses
            return $bckresult;
        }
    }
    return array("message" => "unable to run config action");
}

}
