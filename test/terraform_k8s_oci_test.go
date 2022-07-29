package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestOutputsForK8sOciModule(t *testing.T) {
	// given
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../",
	})
	// defer terraform.Destroy(t, terraformOptions)

	// when
	// terraform.InitAndApply(t, terraformOptions)
	subnet_cidr := terraform.Output(t, terraformOptions, "subnet_cidr")
	vcn_cidr := terraform.Output(t, terraformOptions, "vcn_cidr")

	// then
	assert.Equal(t, "172.16.0.0/24", subnet_cidr)
	assert.Equal(t, "172.16.0.0/20", vcn_cidr)
}
