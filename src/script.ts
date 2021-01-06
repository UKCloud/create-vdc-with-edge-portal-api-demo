import {
  DefaultApi as PortalApi,
  VdcBuildVmType,
  VdcBuildRequestDataTypeEnum,
  BuildState,
  EdgegatewayBuildRequestAttributesConnectivityTypeEnum,
  EdgegatewayBuildRequestTypeEnum
} from "@ccouzens/ukcloud-portal-api";
import { UserApi as VcloudRestApi } from "@ccouzens/vcloud-rest";

const VCLOUD_OPTIONS = {
  headers: { Accept: "application/*+json;version=32.0" }
};

const VDC_BUILD_SLEEP = 30;
const EDGE_GATEWAY_BUILD_SLEEP = 30;

const sleep = (duration: number) =>
  new Promise(r => setTimeout(r, duration * 1000));

export default async (
  portalUrl: string,
  vcloudUrl: string,
  portalEmail: string,
  password: string,
  vcloudUsername: string,
  vcloudOrg: string,
  vdcName: string,
  logger: (message: string) => void
) => {
  let vcloudBearerToken = "";
  const vcloudApi = new VcloudRestApi(
    {
      username: `${vcloudUsername}@${vcloudOrg}`,
      password: password,
      accessToken: () => vcloudBearerToken
    },
    `${vcloudUrl}/api`
  );
  const portalApi = new PortalApi(undefined, portalUrl);

  const accountId = parseInt(vcloudOrg.split("-")[1]);
  const vorgId = parseInt(vcloudOrg.split("-")[2]);

  logger("logging into vCloud ...");
  vcloudBearerToken = (await vcloudApi.sessionsPost(VCLOUD_OPTIONS)).headers[
    "x-vmware-vcloud-access-token"
  ];
  logger("done.");

  logger("getting org urn ... ");
  const orgList = (await vcloudApi.orgGet(VCLOUD_OPTIONS)).data;
  const orgId = orgList.org
    ?.find(org => org.name === vcloudOrg && org.href !== null)
    ?.href?.split("/")
    .pop();
  if (orgId === undefined) {
    throw `Couldn't find org ${vcloudOrg}`;
  }
  logger(orgId);

  logger("logging into Portal ...");
  await portalApi.authenticate({
    email: portalEmail,
    password: password
  });
  logger("done.");

  logger(`initiating build of '${vdcName}' vdc ...`);
  let vdcBuild = (
    await portalApi.createVdc(accountId, vorgId, {
      data: {
        attributes: { name: vdcName, vmType: VdcBuildVmType.ESSENTIAL },
        type: VdcBuildRequestDataTypeEnum.VDC
      }
    })
  ).data;
  logger("done.");

  logger("building vdc ...");
  await sleep(90);
  while (vdcBuild.data.attributes.state !== BuildState.Completed) {
    if (vdcBuild.data.attributes.state === BuildState.Failed) {
      throw "VDC build failed";
    }
    await sleep(VDC_BUILD_SLEEP);
    vdcBuild = (await portalApi.vdcBuild(parseInt(vdcBuild.data.id))).data;
  }
  logger("done.");

  logger("looking for VDC in vCloud Director ...");
  const vdcUrn = (await vcloudApi.orgIdGet(orgId, VCLOUD_OPTIONS)).data.link
    ?.find(
      link =>
        link.type === "application/vnd.vmware.vcloud.vdc+json" &&
        link.rel === "down" &&
        link.name?.endsWith(vdcName)
    )
    ?.href?.split("/")
    ?.pop();
  if (vdcUrn === undefined) {
    throw "Failed to find VDC in vCloud Director";
  }
  logger(vdcUrn);

  logger("logging out of vCloud Director ...");
  await vcloudApi.sessionDelete(VCLOUD_OPTIONS);
  logger("done.");

  logger(`initiating build of '${vdcName}' edge-gateway ...`);
  let edgeGatewayBuild = (
    await portalApi.createEdgeGateway(
      accountId,
      vorgId,
      `urn:vcloud:vdc:${vdcUrn}`,
      {
        data: {
          type: EdgegatewayBuildRequestTypeEnum.EdgeGateway,
          attributes: {
            connectivityType:
              EdgegatewayBuildRequestAttributesConnectivityTypeEnum.Internet
          }
        }
      }
    )
  ).data;
  logger("done.");

  logger("building edge-gateway ...");
  await sleep(90);
  while (edgeGatewayBuild.data.attributes.state !== BuildState.Completed) {
    if (edgeGatewayBuild.data.attributes.state === BuildState.Failed) {
      throw "Edge-gateway build failed";
    }
    await sleep(EDGE_GATEWAY_BUILD_SLEEP);
    edgeGatewayBuild = (
      await portalApi.edgeGatewayBuild(parseInt(edgeGatewayBuild.data.id))
    ).data;
  }
  logger("done.");
};
