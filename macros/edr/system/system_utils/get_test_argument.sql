{% macro get_test_argument(argument_name, value, model_graph_node) %}
  {% if value is defined %}
    {% do elementary.edr_log('get_test_argument ' ~ argument_name ~ ' value is defined') %}
    {% do return(value) %}
  {%- endif %}
  {%- if model_graph_node %}
    {% do elementary.edr_log('get_test_argument ' ~ argument_name ~ ' model_graph_node exists') %}
    {% set elementary_config = elementary.get_elementary_config_from_node(model_graph_node) %}
    {% if elementary_config and elementary_config is mapping %}
        {%- if argument_name in elementary_config %}
            {% do return(elementary_config.get(argument_name)) %}
        {%- endif %}
    {% endif %}
  {% else %}
    {% do elementary.edr_log('get_test_argument ' ~ argument_name ~ ' model_graph_node does not exist') %}
  {% endif %}
  {% set config_value = elementary.get_config_var(argument_name) %}
  {% if config_value is defined %}
    {% do return(config_value) %}
  {% endif %}
  {% do return(none) %}
{% endmacro %}