# AmplifyApp

A sample application to test [Amplify for iOS](https://aws.amazon.com/getting-started/hands-on/build-ios-app-amplify/module-one/) plugins.

## Auth

The iOS application uses the Amplify iOS SDK to sign up/login via AWS Cognito.

### Amplify CLI

You can use the Amplify CLI to provision resources in AWS. In this case, we will create all resources needed in AWS Cognito.

```bash
amplify add auth
```

This initializes a CLI menu of options to configure resources in AWS. Once this is done, two files are created containing information about the resources created.

### Required files

There are two files that are required to run the project (the files output in the section above):
1. `amplifyconfiguration.json`
2. `awsconfiguration.json`

Both have similar content and are used in different versions of the SDK.
