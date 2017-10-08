-- core/connectores
CausalConnector = require "core/connectors/CausalConnector"
CompoundAction = require "core/connectors/CompoundAction"
CompoundCondition = require "core/connectors/CompoundCondition"
ConnectorBase = require "core/connectors/ConnectorBase"
ConnectorParam = require "core/connectors/ConnectorParam"
SimpleAction = require "core/connectors/SimpleAction"
SimpleCondition = require "core/connectors/SimpleCondition"

-- core/content
Body = require "core/content/Body"
Context = require "core/content/Context"
Document = require "core/content/Document"
Head = require "core/content/Head"
Media = require "core/content/Media"

-- core/interface
Area = require "core/interface/Area"
Port = require "core/interface/Port"
Property = require "core/interface/Property"

-- core/layout
Descriptor = require "core/layout/Descriptor"
DescriptorBase = require "core/layout/DescriptorBase"
DescriptorParam = require "core/layout/DescriptorParam"
Region = require "core/layout/Region"
RegionBase = require "core/layout/RegionBase"

-- core/linking
Bind = require "core/linking/Bind"
BindParam = require "core/linking/BindParam"
Link = require "core/linking/Link"
LinkParam = require "core/linking/LinkParam"

-- core/linking
CompositeRule = require "core/switches/CompositeRule"
DefaultComponent = require "core/switches/DefaultComponent"
Mapping = require "core/switches/Mapping"
Rule = require "core/switches/Rule"
RuleBase = require "core/switches/RuleBase"
Switch = require "core/switches/Switch"
SwitchPort = require "core/switches/SwitchPort"