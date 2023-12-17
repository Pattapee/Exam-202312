# Examination QA Automated Testing

Automated testing API transfer amount with Robotframework
-API transfer

# How to run project

Install python and package

```
  pip install -r requirements.txt
```

- Install nodeJS
- Install Mountebank for mockAPI response

```
  npm install -g mountebank
```

Run All test

```bash
  robot -d ./results -v ENV:uat .\test\xxx.robot
```

Run test by tags

```bash
  robot -d ./results -v ENV:uat -i TC1 .\test\xxx.robot
```

## Link Test report, Test case
[Documentation] - https://docs.google.com/spreadsheets/d/1UZBsExzydOBnzaC8GCrRzkr5wI621jEj/edit#gid=1034356122

## 💬 Support

For support, email pattapees@gmail.com
