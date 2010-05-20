It's included in ActiveScaffold, so it's only needed for rails-2.3 branch and previous ones.

Adds an authorized_for_destroy? method which check all associations to forbid destroy action when an association with dependent protect is not empty.

Instalation
===========

script/plugin install git://github.com/scambra/active_scaffold_dependent_protect.git

ActiveScaffold loads the bridge if you have installed the dependent_protect plugin:
http://github.com/scambra/dependent_protect
