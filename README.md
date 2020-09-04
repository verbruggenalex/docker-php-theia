# Docker Theia PHP

A Docker image based on [thecodingmachine/docker-images-php](https://github.com/thecodingmachine/docker-images-php#general-purpose-php-images-for-docker)
with addition of the browser based IDE [Theia](https://theia-ide.org/) set up
for coding PHP. **This is not an official docker image!** Subject to change as
it is used for personal development purposes.

## Notes

### Custom plugins vsix files manually downloaded:

- https://marketplace.visualstudio.com/items?itemName=DmitryDorofeev.empty-indent
- https://marketplace.visualstudio.com/items?itemName=kaffeine.advanced-drupal-8-snippets
- https://marketplace.visualstudio.com/items?itemName=mblode.twig-language-2
- https://marketplace.visualstudio.com/items?itemName=ValeryanM.vscode-phpsab *
- https://marketplace.visualstudio.com/items?itemName=WakaTime.vscode-wakatime

\* Issue with phpsab where phpcbf does not work correctly. Needs cli execution.


### VS Code configuration documentation:

https://www.drupal.org/docs/develop/development-tools/configuring-visual-studio-code

#### Breadcrumb (not available for Theia):

https://github.com/eclipse-theia/theia/pull/6371

### TODO's:

- add behat extension?
- add phpunit extension?
- allow local settings.json to be loaded for .theia
- interesting extensions: https://www.youtube.com/watch?v=c5GAS_PMXDs
- check out ssh: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh
