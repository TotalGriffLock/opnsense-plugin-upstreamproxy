<?php
namespace OPNsense\UpstreamProxy;
class IndexController extends \OPNsense\Base\IndexController
{
    public function indexAction()
    {
        // pick the template to serve to our users.
        $this->view->generalForm = $this->getForm("general");
        $this->view->pick('OPNsense/UpstreamProxy/index');
    }
}
