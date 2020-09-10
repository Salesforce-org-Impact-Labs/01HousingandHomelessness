public class customMetadataCallback implements Metadata.DeployCallback {
  public void handleResult(
    Metadata.DeployResult result,
    Metadata.DeployCallbackContext context
  ) {
    if (result.status == Metadata.DeployStatus.Succeeded) {
      System.debug(' ===>' + result);
    } else {
      // Deployment was not successful
      System.debug(' ===> fail ' + result);
    }
  }
}