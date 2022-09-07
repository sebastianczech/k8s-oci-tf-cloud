package test

import (
	"encoding/json"
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

type TerraformStateSubnet struct {
	Value string `json:"value"`
}

type TerraformStateVcn struct {
	Value string `json:"value"`
}

type TerraformStateOutputs struct {
	TerraformStateSubnet `json:"subnet_state"`
	TerraformStateVcn    `json:"vcn_state"`
}

type TerraformStateChildModuleResource struct {
	Address      string `json:"address"`
	ProviderName string `json:"provider_name"`
	Type         string `json:"type"`
	Name         string `json:"Name"`
}

type TerraformStateChildModule struct {
	TerraformStateChildModuleResourceList []TerraformStateChildModuleResource `json:"resources"`
}

type TerraformStateRootModule struct {
	TerraformStateChildModuleList []TerraformStateChildModule `json:"child_modules"`
}

type TerraformStateValues struct {
	TerraformStateOutputs    `json:"outputs"`
	TerraformStateRootModule `json:"root_module"`
}

type TerraformState struct {
	TerraformVersion     string `json:"terraform_version"`
	TerraformStateValues `json:"values"`
}

func TestStateForK8sOciModule(t *testing.T) {
	// given
	k8s := TerraformState{}
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../",
		Logger:       logger.Discard,
	})

	loadBalancer := TerraformStateChildModuleResource{
		Address:      "module.infra-k8s-oracle-cloud.oci_network_load_balancer_network_load_balancer.k8s_network_load_balancer",
		ProviderName: "registry.terraform.io/hashicorp/oci",
		Type:         "oci_network_load_balancer_network_load_balancer",
		Name:         "k8s_network_load_balancer",
	}

	// when
	fmt.Print("========================\nchecking terraform state\n========================\n")
	result := terraform.Show(t, terraformOptions)

	json.Unmarshal([]byte(result), &k8s)
	logger.Log(t, "K8sOciState: ", k8s)

	// then
	assert.Equal(t, "1.2.8", k8s.TerraformVersion)
	assert.Equal(t, "AVAILABLE", k8s.TerraformStateValues.TerraformStateOutputs.TerraformStateSubnet.Value)
	assert.Equal(t, "AVAILABLE", k8s.TerraformStateValues.TerraformStateOutputs.TerraformStateVcn.Value)
	assert.Equal(t, 2, len(k8s.TerraformStateValues.TerraformStateRootModule.TerraformStateChildModuleList))
	assert.Equal(t, 16, len(k8s.TerraformStateValues.TerraformStateRootModule.TerraformStateChildModuleList[0].TerraformStateChildModuleResourceList))
	assert.Equal(t, 30, len(k8s.TerraformStateValues.TerraformStateRootModule.TerraformStateChildModuleList[1].TerraformStateChildModuleResourceList))
	assert.Contains(t, k8s.TerraformStateValues.TerraformStateRootModule.TerraformStateChildModuleList[1].TerraformStateChildModuleResourceList, loadBalancer)
}
