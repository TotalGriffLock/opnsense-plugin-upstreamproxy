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

}
