import { action } from "@storybook/addon-actions";
import {
  MockProxyLatencies,
  MockWorkspace,
  MockWorkspaceResource,
} from "testHelpers/entities";
import { AgentRow } from "./AgentRow";
import { Resources } from "./Resources";
import { ProxyContext, getPreferredProxy } from "contexts/ProxyContext";
import type { Meta, StoryObj } from "@storybook/react";
import { type WorkspaceAgent } from "api/typesGenerated";

const meta: Meta<typeof Resources> = {
  title: "components/Resources/Resources",
  component: Resources,
  args: {
    resources: [MockWorkspaceResource],
    agentRow: getAgentRow,
  },
};

export default meta;
type Story = StoryObj<typeof Resources>;

export const Example: Story = {};

const nullDevice = {
  created_at: "",
  job_id: "",
  workspace_transition: "start",
  type: "null_resource",
  hide: false,
  icon: "",
  daily_cost: 0,
} as const;

const short = {
  key: "Short",
  value: "Hi!",
  sensitive: false,
};
const long = {
  key: "Long",
  value: "The quick brown fox jumped over the lazy dog",
  sensitive: false,
};
const reallyLong = {
  key: "Really long",
  value:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  sensitive: false,
};

export const BunchOfDevicesWithMetadata: Story = {
  args: {
    resources: [
      MockWorkspaceResource,
      {
        ...nullDevice,
        id: "e8c846da",
        name: "device1",
        metadata: [short],
      },
      {
        ...nullDevice,
        id: "a1b11343",
        name: "device3",
        metadata: [long],
      },
      {
        ...nullDevice,
        id: "09ab7e8c",
        name: "device3",
        metadata: [reallyLong],
      },
      {
        ...nullDevice,
        id: "0a09fa91",
        name: "device2",
        metadata: Array.from({ length: 8 }, (_, i) => ({
          ...short,
          key: `Short ${i}`,
        })),
      },
      {
        ...nullDevice,
        id: "d0b9eb9d",
        name: "device4",
        metadata: Array.from({ length: 4 }, (_, i) => ({
          ...long,
          key: `Short ${i}`,
        })),
      },
      {
        ...nullDevice,
        id: "a6c69587",
        name: "device5",
        metadata: Array.from({ length: 8 }, (_, i) =>
          i % 2 === 0
            ? { ...short, key: `Short ${i}` }
            : { ...long, key: `Long ${i}` },
        ),
      },
      {
        ...nullDevice,
        id: "3af84e31",
        name: "device6",
        metadata: Array.from({ length: 8 }, (_, i) => ({
          ...reallyLong,
          key: `Really long ${i}`,
        })),
      },
    ],
    agentRow: getAgentRow,
  },
};

function getAgentRow(agent: WorkspaceAgent): JSX.Element {
  return (
    <ProxyContext.Provider
      value={{
        proxyLatencies: MockProxyLatencies,
        proxy: getPreferredProxy([], undefined),
        proxies: [],
        isLoading: false,
        isFetched: true,
        setProxy: () => {
          return;
        },
        clearProxy: () => {
          return;
        },
        refetchProxyLatencies: (): Date => {
          return new Date();
        },
      }}
    >
      <AgentRow
        showApps
        key={agent.id}
        agent={agent}
        workspace={MockWorkspace}
        serverVersion=""
        onUpdateAgent={action("updateAgent")}
      />
    </ProxyContext.Provider>
  );
}
