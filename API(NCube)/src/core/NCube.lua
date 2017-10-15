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
CompositeNodes = require "core/content/CompositeNode"
Context = CompositeNodes[1]
Switch = CompositeNodes[2]
Document = require "core/content/Document"
Head = require "core/content/Head"
Media = require "core/content/Media"

-- core/content
ImportBase = require "core/importation/ImportBase"
ImportedDocumentBase = require "core/importation/ImportedDocumentBase"
ImportNCL = require "core/importation/ImportNCL"

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

-- core/metadata
Meta = require "core/metadata/Meta"

-- core/switches
BindRule = require "core/switches/BindRule"
CompositeRule = require "core/switches/CompositeRule"
DefaultComponent = require "core/switches/DefaultComponent"
DefaultDescriptor = require "core/switches/DefaultDescriptor"
DescriptorSwitch = require "core/switches/DescriptorSwitch"
Mapping = require "core/switches/Mapping"
Rule = require "core/switches/Rule"
RuleBase = require "core/switches/RuleBase"
SwitchPort = require "core/switches/SwitchPort"

-- core/transition
Transition = require "core/transition/Transition"
TransitionBase = require "core/transition/TransitionBase"