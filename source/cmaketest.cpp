#include <string>

#include "cmaketest/cmaketest.hpp"

exported_class::exported_class()
    : m_name {"cmaketest"}
{
}

auto exported_class::name() const -> const char*
{
  return m_name.c_str();
}
