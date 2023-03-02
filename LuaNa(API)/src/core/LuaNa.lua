package.path = package.path .. ";../../?.lua"

-- core/connectores
AssessmentStatement = require "../../src/core/connectors/AssessmentStatement"
AttributeAssessment = require "../../src/core/connectors/AttributeAssessment"
CausalConnector = require "../../src/core/connectors/CausalConnector"
CompoundAction = require "../../src/core/connectors/CompoundAction"
CompoundCondition = require "../../src/core/connectors/CompoundCondition"
CompoundStatement = require "../../src/core/connectors/CompoundStatement"
ConnectorBase = require "../../src/core/connectors/ConnectorBase"
ConnectorParam = require "../../src/core/connectors/ConnectorParam"
SimpleAction = require "../../src/core/connectors/SimpleAction"
SimpleCondition = require "../../src/core/connectors/SimpleCondition"
ValueAssessment = require "../../src/core/connectors/ValueAssessment"

-- core/content
Body = require "../../src/core/content/Body"
CompositeNodes = require "../../src/core/content/CompositeNode"
Context = CompositeNodes[1]
Switch = CompositeNodes[2]
Document = require "../../src/core/content/Document"
Head = require "../../src/core/content/Head"
Media = require "../../src/core/content/Media"

-- core/content
ImportBase = require "../../src/core/importation/ImportBase"
ImportedDocumentBase = require "../../src/core/importation/ImportedDocumentBase"
ImportNCL = require "../../src/core/importation/ImportNCL"

-- core/interface
Area = require "../../src/core/interface/Area"
Port = require "../../src/core/interface/Port"
Property = require "../../src/core/interface/Property"

-- core/layout
Descriptor = require "../../src/core/layout/Descriptor"
DescriptorBase = require "../../src/core/layout/DescriptorBase"
DescriptorParam = require "../../src/core/layout/DescriptorParam"
Region = require "../../src/core/layout/Region"
RegionBase = require "../../src/core/layout/RegionBase"

-- core/linking
Bind = require "../../src/core/linking/Bind"
BindParam = require "../../src/core/linking/BindParam"
Link = require "../../src/core/linking/Link"
LinkParam = require "../../src/core/linking/LinkParam"

-- core/metadata
Meta = require "../../src/core/metadata/Meta"
MetaData = require "../../src/core/metadata/MetaData"

-- core/switches
BindRule = require "../../src/core/switches/BindRule"
CompositeRule = require "../../src/core/switches/CompositeRule"
DefaultComponent = require "../../src/core/switches/DefaultComponent"
DefaultDescriptor = require "../../src/core/switches/DefaultDescriptor"
DescriptorSwitch = require "../../src/core/switches/DescriptorSwitch"
Mapping = require "../../src/core/switches/Mapping"
Rule = require "../../src/core/switches/Rule"
RuleBase = require "../../src/core/switches/RuleBase"
SwitchPort = require "../../src/core/switches/SwitchPort"

-- core/transition
Transition = require "../../src/core/transition/Transition"
TransitionBase = require "../../src/core/transition/TransitionBase"
