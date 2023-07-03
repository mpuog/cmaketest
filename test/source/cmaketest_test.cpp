#include <string>

#include "cmaketest/cmaketest.hpp"

auto main() -> int
{
  auto const exported = exported_class {};

  return std::string("cmaketest") == exported.name() ? 0 : 1;
}
