class ConfirmAllClassRenames < ActiveRecord::Migration[4.2]
  include MigrationHelper

  NAME_MAP = Hash[*%w(
    MiqEvent                                              MiqEventDefinition
    MiqEventSet                                           MiqEventDefinitionSet

    MiqEventCatcher                                       ManageIQ::Providers::BaseManager::EventCatcher
    MiqEmsMetricsCollectorWorker                          ManageIQ::Providers::BaseManager::MetricsCollectorWorker
    MiqEmsRefreshWorker                                   ManageIQ::Providers::BaseManager::RefreshWorker
    EmsRefresh::Refreshers::BaseRefresher                 ManageIQ::Providers::BaseManager::Refresher
    EmsCloud                                              ManageIQ::Providers::CloudManager
    AuthKeyPairCloud                                      ManageIQ::Providers::CloudManager::AuthKeyPair
    MiqProvisionCloud                                     ManageIQ::Providers::CloudManager::Provision
    MiqProvisionCloudWorkflow                             ManageIQ::Providers::CloudManager::ProvisionWorkflow
    EmsRefresh::Parsers::Cloud                            ManageIQ::Providers::CloudManager::RefreshParser
    TemplateCloud                                         ManageIQ::Providers::CloudManager::Template
    VmCloud                                               ManageIQ::Providers::CloudManager::Vm
    ConfigurationManager                                  ManageIQ::Providers::ConfigurationManager
    EmsContainer                                          ManageIQ::Providers::ContainerManager
    EmsInfra                                              ManageIQ::Providers::InfraManager
    MiqProvisionInfraWorkflow                             ManageIQ::Providers::InfraManager::ProvisionWorkflow
    TemplateInfra                                         ManageIQ::Providers::InfraManager::Template
    VmInfra                                               ManageIQ::Providers::InfraManager::Vm
    ProvisioningManager                                   ManageIQ::Providers::ProvisioningManager

    EmsAmazon                                             ManageIQ::Providers::Amazon::CloudManager
    AuthKeyPairAmazon                                     ManageIQ::Providers::Amazon::CloudManager::AuthKeyPair
    AvailabilityZoneAmazon                                ManageIQ::Providers::Amazon::CloudManager::AvailabilityZone
    CloudVolumeAmazon                                     ManageIQ::Providers::Amazon::CloudManager::CloudVolume
    CloudVolumeSnapshotAmazon                             ManageIQ::Providers::Amazon::CloudManager::CloudVolumeSnapshot
    MiqEventCatcherAmazon                                 ManageIQ::Providers::Amazon::CloudManager::EventCatcher
    FlavorAmazon                                          ManageIQ::Providers::Amazon::CloudManager::Flavor
    FloatingIpAmazon                                      ManageIQ::Providers::Amazon::CloudManager::FloatingIp
    MiqEmsMetricsCollectorWorkerAmazon                    ManageIQ::Providers::Amazon::CloudManager::MetricsCollectorWorker
    ServiceOrchestration::OptionConverterAmazon           ManageIQ::Providers::Amazon::CloudManager::OrchestrationServiceOptionConverter
    OrchestrationStackAmazon                              ManageIQ::Providers::Amazon::CloudManager::OrchestrationStack
    MiqProvisionAmazon                                    ManageIQ::Providers::Amazon::CloudManager::Provision
    MiqProvisionAmazonWorkflow                            ManageIQ::Providers::Amazon::CloudManager::ProvisionWorkflow
    EmsRefresh::Parsers::Ec2                              ManageIQ::Providers::Amazon::CloudManager::RefreshParser
    MiqEmsRefreshWorkerAmazon                             ManageIQ::Providers::Amazon::CloudManager::RefreshWorker
    EmsRefresh::Refreshers::Ec2Refresher                  ManageIQ::Providers::Amazon::CloudManager::Refresher
    SecurityGroupAmazon                                   ManageIQ::Providers::Amazon::CloudManager::SecurityGroup
    TemplateAmazon                                        ManageIQ::Providers::Amazon::CloudManager::Template
    VmAmazon                                              ManageIQ::Providers::Amazon::CloudManager::Vm
    ConfigurationManagerForeman                           ManageIQ::Providers::Foreman::ConfigurationManager
    ConfigurationProfileForeman                           ManageIQ::Providers::Foreman::ConfigurationManager::ConfigurationProfile
    ConfiguredSystemForeman                               ManageIQ::Providers::Foreman::ConfigurationManager::ConfiguredSystem
    MiqProvisionTaskConfiguredSystemForeman               ManageIQ::Providers::Foreman::ConfigurationManager::ProvisionTask
    MiqProvisionConfiguredSystemForemanWorkflow           ManageIQ::Providers::Foreman::ConfigurationManager::ProvisionWorkflow
    MiqEmsRefreshWorkerForemanConfiguration               ManageIQ::Providers::Foreman::ConfigurationManager::RefreshWorker
    EmsRefresh::Refreshers::ForemanConfigurationRefresher ManageIQ::Providers::Foreman::ConfigurationManager::Refresher
    ProviderForeman                                       ManageIQ::Providers::Foreman::Provider
    ProvisioningManagerForeman                            ManageIQ::Providers::Foreman::ProvisioningManager
    EmsRefresh::Parsers::Foreman                          ManageIQ::Providers::Foreman::ProvisioningManager::RefreshParser
    MiqEmsRefreshWorkerForemanProvisioning                ManageIQ::Providers::Foreman::ProvisioningManager::RefreshWorker
    EmsRefresh::Refreshers::ForemanProvisioningRefresher  ManageIQ::Providers::Foreman::ProvisioningManager::Refresher
    EmsKubernetes                                         ManageIQ::Providers::Kubernetes::ContainerManager
    MiqEventCatcherKubernetes                             ManageIQ::Providers::Kubernetes::ContainerManager::EventCatcher
    EmsRefresh::Parsers::Kubernetes                       ManageIQ::Providers::Kubernetes::ContainerManager::RefreshParser
    MiqEmsRefreshWorkerKubernetes                         ManageIQ::Providers::Kubernetes::ContainerManager::RefreshWorker
    EmsRefresh::Refreshers::KubernetesRefresher           ManageIQ::Providers::Kubernetes::ContainerManager::Refresher
    EmsMicrosoft                                          ManageIQ::Providers::Microsoft::InfraManager
    HostMicrosoft                                         ManageIQ::Providers::Microsoft::InfraManager::Host
    EmsMicrosoft::Powershell                              ManageIQ::Providers::Microsoft::InfraManager::Powershell
    EmsRefresh::Parsers::Scvmm                            ManageIQ::Providers::Microsoft::InfraManager::RefreshParser
    MiqEmsRefreshWorkerMicrosoft                          ManageIQ::Providers::Microsoft::InfraManager::RefreshWorker
    EmsRefresh::Refreshers::ScvmmRefresher                ManageIQ::Providers::Microsoft::InfraManager::Refresher
    TemplateMicrosoft                                     ManageIQ::Providers::Microsoft::InfraManager::Template
    VmMicrosoft                                           ManageIQ::Providers::Microsoft::InfraManager::Vm
    EmsOpenstack                                          ManageIQ::Providers::Openstack::CloudManager
    AvailabilityZoneOpenstack                             ManageIQ::Providers::Openstack::CloudManager::AvailabilityZone
    AvailabilityZoneOpenstackNull                         ManageIQ::Providers::Openstack::CloudManager::AvailabilityZoneNull
    CloudResourceQuotaOpenstack                           ManageIQ::Providers::Openstack::CloudManager::CloudResourceQuota
    CloudTenantOpenstack                                  ManageIQ::Providers::Openstack::CloudManager::CloudTenant
    CloudVolumeOpenstack                                  ManageIQ::Providers::Openstack::CloudManager::CloudVolume
    CloudVolumeSnapshotOpenstack                          ManageIQ::Providers::Openstack::CloudManager::CloudVolumeSnapshot
    MiqEventCatcherOpenstack                              ManageIQ::Providers::Openstack::CloudManager::EventCatcher
    FlavorOpenstack                                       ManageIQ::Providers::Openstack::CloudManager::Flavor
    FloatingIpOpenstack                                   ManageIQ::Providers::Openstack::CloudManager::FloatingIp
    MiqEmsMetricsCollectorWorkerOpenstack                 ManageIQ::Providers::Openstack::CloudManager::MetricsCollectorWorker
    ServiceOrchestration::OptionConverterOpenstack        ManageIQ::Providers::Openstack::CloudManager::OrchestrationServiceOptionConverter
    OrchestrationStackOpenstack                           ManageIQ::Providers::Openstack::CloudManager::OrchestrationStack
    MiqProvisionOpenstack                                 ManageIQ::Providers::Openstack::CloudManager::Provision
    MiqProvisionOpenstackWorkflow                         ManageIQ::Providers::Openstack::CloudManager::ProvisionWorkflow
    EmsRefresh::Parsers::Openstack                        ManageIQ::Providers::Openstack::CloudManager::RefreshParser
    MiqEmsRefreshWorkerOpenstack                          ManageIQ::Providers::Openstack::CloudManager::RefreshWorker
    EmsRefresh::Refreshers::OpenstackRefresher            ManageIQ::Providers::Openstack::CloudManager::Refresher
    SecurityGroupOpenstack                                ManageIQ::Providers::Openstack::CloudManager::SecurityGroup
    TemplateOpenstack                                     ManageIQ::Providers::Openstack::CloudManager::Template
    VmOpenstack                                           ManageIQ::Providers::Openstack::CloudManager::Vm
    VmOpenstack::RemoteConsole                            ManageIQ::Providers::Openstack::CloudManager::Vm::RemoteConsole
    EmsOpenstackInfra                                     ManageIQ::Providers::Openstack::InfraManager
    AuthKeyPairOpenstack                                  ManageIQ::Providers::Openstack::InfraManager::AuthKeyPair
    MiqEventCatcherOpenstackInfra                         ManageIQ::Providers::Openstack::InfraManager::EventCatcher
    HostOpenstackInfra                                    ManageIQ::Providers::Openstack::InfraManager::Host
    MiqEmsMetricsCollectorWorkerOpenstackInfra            ManageIQ::Providers::Openstack::InfraManager::MetricsCollectorWorker
    OrchestrationStackOpenstackInfra                      ManageIQ::Providers::Openstack::InfraManager::OrchestrationStack
    EmsRefresh::Parsers::OpenstackInfra                   ManageIQ::Providers::Openstack::InfraManager::RefreshParser
    MiqEmsRefreshWorkerOpenstackInfra                     ManageIQ::Providers::Openstack::InfraManager::RefreshWorker
    EmsRefresh::Refreshers::OpenstackInfraRefresher       ManageIQ::Providers::Openstack::InfraManager::Refresher
    ProviderOpenstack                                     ManageIQ::Providers::Openstack::Provider
    EmsRedhat                                             ManageIQ::Providers::Redhat::InfraManager
    MiqEventCatcherRedhat                                 ManageIQ::Providers::Redhat::InfraManager::EventCatcher
    HostRedhat                                            ManageIQ::Providers::Redhat::InfraManager::Host
    MiqEmsMetricsCollectorWorkerRedhat                    ManageIQ::Providers::Redhat::InfraManager::MetricsCollectorWorker
    MiqProvisionRedhat                                    ManageIQ::Providers::Redhat::InfraManager::Provision
    MiqProvisionRedhatViaIso                              ManageIQ::Providers::Redhat::InfraManager::ProvisionViaIso
    MiqProvisionRedhatViaPxe                              ManageIQ::Providers::Redhat::InfraManager::ProvisionViaPxe
    MiqProvisionRedhatWorkflow                            ManageIQ::Providers::Redhat::InfraManager::ProvisionWorkflow
    MiqEmsRefreshWorkerRedhat                             ManageIQ::Providers::Redhat::InfraManager::RefreshWorker
    EmsRefresh::Refreshers::RhevmRefresher                ManageIQ::Providers::Redhat::InfraManager::Refresher
    TemplateRedhat                                        ManageIQ::Providers::Redhat::InfraManager::Template
    VmRedhat                                              ManageIQ::Providers::Redhat::InfraManager::Vm
    VmRedhat::RemoteConsole                               ManageIQ::Providers::Redhat::InfraManager::Vm::RemoteConsole
    EmsVmware                                             ManageIQ::Providers::Vmware::InfraManager
    MiqEventCatcherVmware                                 ManageIQ::Providers::Vmware::InfraManager::EventCatcher
    HostVmware                                            ManageIQ::Providers::Vmware::InfraManager::Host
    HostVmwareEsx                                         ManageIQ::Providers::Vmware::InfraManager::HostEsx
    MiqEmsMetricsCollectorWorkerVmware                    ManageIQ::Providers::Vmware::InfraManager::MetricsCollectorWorker
    MiqProvisionVmware                                    ManageIQ::Providers::Vmware::InfraManager::Provision
    MiqProvisionVmwareViaPxe                              ManageIQ::Providers::Vmware::InfraManager::ProvisionViaPxe
    MiqProvisionVmwareWorkflow                            ManageIQ::Providers::Vmware::InfraManager::ProvisionWorkflow
    EmsRefresh::Parsers::Vc                               ManageIQ::Providers::Vmware::InfraManager::RefreshParser
    EmsRefresh::Parsers::Vc::Filter                       ManageIQ::Providers::Vmware::InfraManager::RefreshParser::Filter
    MiqEmsRefreshWorkerVmware                             ManageIQ::Providers::Vmware::InfraManager::RefreshWorker
    EmsRefresh::Refreshers::VcRefresher                   ManageIQ::Providers::Vmware::InfraManager::Refresher
    TemplateVmware                                        ManageIQ::Providers::Vmware::InfraManager::Template
    VmVmware                                              ManageIQ::Providers::Vmware::InfraManager::Vm)]

  def change
    rename_class_references(NAME_MAP)
  end
end