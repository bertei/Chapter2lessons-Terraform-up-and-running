# Deploying a Configurable Web Server
* You might have noticed that the web server code has the port 8080 duplicated in both the security group and the User Data configuration. This violates the Don’t Repeat Yourself (DRY) principle: every piece of knowledge must have a single, unambiguous, authoritative representation within a system. If you have the port number in two places, it’s easy to update it in one place but forget to make the same change in the other place.
## Input variables
* To allow you to make your code more DRY and more configurable, Terraform allows you to define input variables. Here’s the syntax for    declaring a variable:
```
variable "NAME" { [CONFIG ...]
}
```
The body of the variable declaration can contain the following optional parameters:
* description: It’s always a good idea to use this parameter to document how a variable is used. Your teammates will be able to see this description not only while reading the code but also when running the plan or apply commands (you’ll see an example of this shortly).
* default: There are a number of ways to provide a value for the variable, including passing it in at the command line (using the -var option), via a file (using the -var- file option), or via an environment variable (Terraform looks for environment variables of the name TF_VAR_<variable_name>). If no value is passed in, the variable will fall back to this default value. If there is no default value, Terraform will interactively prompt the user for one.
* type: This allows you to enforce type constraints on the variables a user passes in. Terraform supports a number of type constraints, including string, number, bool, list, map, set, object, tuple, and any. It’s always a good idea to define a type constraint to catch simple errors. If you don’t specify a type, Terraform assumes the type is any.
* validation: This allows you to define custom validation rules for the input variable that go beyond basic type checks, such as enforcing minimum or maximum values on a number.
* sensitive: If you set this parameter to true on an input variable, Terraform will not log it when you run plan or apply. You should use this on any secrets you pass into your Terraform code via variables: e.g., passwords, API keys, etc.
## Output variables
* In addition to input variables, Terraform also allows you to define output variables by using the following syntax:
```
    output "<NAME>" {
      value = <VALUE>
      [CONFIG ...]
}
````
* description: It’s always a good idea to use this parameter to document what type of data is contained in the output variable.
* sensitive: Set this parameter to true to instruct Terraform not to log this output at the end of plan or apply. This is useful if the output variable contains secrets such as passwords or private keys. Note that if your output variable references an input variable or resource attribute marked with sensitive = true, you are required to mark the output variable with sensitive = true as well to indicate you are intentionally outputting a secret.
* Terraform will display outputs in console after terraform apply, but you can also use the **terraform output** command.