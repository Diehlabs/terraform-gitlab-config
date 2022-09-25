package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

var (
	uniqueId        = random.UniqueId()
	workingDir      = "../examples/full"
	terraformBinary = "/usr/local/bin/terraform"
)

func TestMyModule(t *testing.T) {
	if tfCliBin := os.Getenv("TF_CLI_PATH"); tfCliBin != "" {
		terraformBinary = tfCliBin
	}

	if tfdir := os.Getenv("TERRATEST_WORKING_DIR"); tfdir != "" {
		workingDir = tfdir
	}

	// Use the Gitlab Job ID as the unique ID.
	// If running locally, the generated unique ID will be used instead.
	if unid := os.Getenv("CI_JOB_ID"); unid != "" {
		uniqueId = unid
	}

	terraformVars := map[string]interface{}{
		"unique_id":  uniqueId,
	}

	// return terraformOptions from terratest_helpers
	// terraformOptions := SetupTesting(t, workingDir, terraformBinary, terraformVars, nil)
	SetupTesting(t, workingDir, terraformBinary, terraformVars, nil)

	// Destroy the infra after testing is finished
	defer test_structure.RunTestStage(t, "terraform_destroy", func() {
		TerraformDestroy(t, workingDir)
	})

	// Deploy using Terraform
	test_structure.RunTestStage(t, "terraform_deploy", func() {
		DeployUsingTerraform(t, workingDir)
	})

	// resourceTests(t, terraformOptions)

	// Redeploy using Terraform and ensure idempotency
	test_structure.RunTestStage(t, "terraform_redeploy", func() {
		RedeployUsingTerraform(t, workingDir)
	})

}

func resourceTests(t *testing.T, terraformOptions *terraform.Options) {
	test_structure.RunTestStage(t, "run_tests", func() {

		// ensure the project name output equals the expected name based on the tf var unique_id appended to the name specified in the example tf code
		t.Run("Project Name - basic", func(t *testing.T) {
			expectedProjName := fmt.Sprintf("terratest-project-module-%s", terraformOptions.Vars["unique_id"].(string))
			outputProjName := terraform.Output(t, terraformOptions, "project_name")
			assert.Equal(t, outputProjName, expectedProjName)
		})

		// ensure the project name output equals the expected name based on the tf var unique_id appended to the name specified in the example tf code
		t.Run("Project Name - extended", func(t *testing.T) {
			expectedProjName := fmt.Sprintf("terratest-project-module-ext-%s", terraformOptions.Vars["unique_id"].(string))
			outputProjName := terraform.Output(t, terraformOptions, "project_name_ext")
			assert.Equal(t, outputProjName, expectedProjName)
		})
	})
}
