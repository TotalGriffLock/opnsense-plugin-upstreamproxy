{{ partial("layout_partials/base_form",['fields':generalForm,'id':'frm_GeneralSettings'])}}
<script type="text/javascript">
    $( document ).ready(function() {
        var data_get_map = {'frm_GeneralSettings':"/api/upstreamproxy/settings/get"};
        mapDataToFormUI(data_get_map).done(function(data){
            // place actions to run after load, for example update form styles.
            updateVisibility();
            document.getElementById("upstreamproxy.general.useHttpProxy").addEventListener('click', updateVisibility);
            document.getElementById("upstreamproxy.general.useHttpsProxy").addEventListener('click', updateVisibility);
            document.getElementById("upstreamproxy.general.useFtpProxy").addEventListener('click', updateVisibility);
        });

        // link save button to API set action
        $("#saveAct").click(function(){
            saveFormToEndpoint(url="/api/upstreamproxy/settings/set",formid='frm_GeneralSettings',callback_ok=function(){
                // action to run after successful save, for example reconfigure service.
		ajaxCall(url="/api/upstreamproxy/service/reload", sendData={},callback=function(data,status) {
		    // action to run after reload
			window.location.reload();
		});
            });
        });


    });

  function updateVisibility() {
    if (document.getElementById("upstreamproxy.general.useHttpProxy").checked == 0) {
      // Use http proxy is off, hide relevant elements
      document.getElementById("row_upstreamproxy.general.httpProxyProto").style="display: none";
      document.getElementById("row_upstreamproxy.general.httpProxyAddress").style="display: none;";
      document.getElementById("row_upstreamproxy.general.httpProxyPort").style="display: none;";
    } else {
      // Use http proxy is on, display relevant elements
      document.getElementById("row_upstreamproxy.general.httpProxyProto").style="display: table-row;";
      document.getElementById("row_upstreamproxy.general.httpProxyAddress").style="display: table-row;";
      document.getElementById("row_upstreamproxy.general.httpProxyPort").style="display: table-row;";
    }
    if (document.getElementById("upstreamproxy.general.useHttpsProxy").checked == 0) {
      // Use https proxy is off, hide relevant elements
      document.getElementById("row_upstreamproxy.general.httpsProxyProto").style="display: none";
      document.getElementById("row_upstreamproxy.general.httpsProxyAddress").style="display: none;";
      document.getElementById("row_upstreamproxy.general.httpsProxyPort").style="display: none;";
    } else {
      // Use https proxy is on, display relevant elements
      document.getElementById("row_upstreamproxy.general.httpsProxyProto").style="display: table-row;";
      document.getElementById("row_upstreamproxy.general.httpsProxyAddress").style="display: table-row;";
      document.getElementById("row_upstreamproxy.general.httpsProxyPort").style="display: table-row;";
    }
    if (document.getElementById("upstreamproxy.general.useFtpProxy").checked == 0) {
      // Use ftp proxy is off, hide relevant elements
      document.getElementById("row_upstreamproxy.general.ftpProxyProto").style="display: none";
      document.getElementById("row_upstreamproxy.general.ftpProxyAddress").style="display: none;";
      document.getElementById("row_upstreamproxy.general.ftpProxyPort").style="display: none;";
    } else {
      // Use ftp proxy is on, display relevant elements
      document.getElementById("row_upstreamproxy.general.ftpProxyProto").style="display: table-row;";
      document.getElementById("row_upstreamproxy.general.ftpProxyAddress").style="display: table-row;";
      document.getElementById("row_upstreamproxy.general.ftpProxyPort").style="display: table-row;";
    }
  }
</script>

<div class="col-md-12">
    <button class="btn btn-primary"  id="saveAct" type="button"><b>{{ lang._('Save') }}</b></button>
</div>
