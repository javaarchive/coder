package coderd_test

import (
	"context"
	"testing"

	"github.com/coder/coder/coderd/coderdtest"
	"github.com/coder/coder/coderd/rbac"
	"github.com/coder/coder/enterprise/coderd"
	"github.com/coder/coder/testutil"
)

// TestAuthorizeAllEndpoints will check `authorize` is called on every endpoint registered.
func TestAuthorizeAllEndpoints(t *testing.T) {
	t.Parallel()
	ctx, cancel := context.WithTimeout(context.Background(), testutil.WaitLong)
	defer cancel()
	a := coderdtest.NewAuthTester(ctx, t, &coderdtest.Options{APIBuilder: coderd.NewEnterprise})
	skipRoutes, assertRoute := coderdtest.AGPLRoutes(a)
	assertRoute["POST:/api/v2/licenses"] = coderdtest.RouteCheck{
		AssertAction: rbac.ActionCreate,
		AssertObject: rbac.ResourceLicense,
	}
	a.Test(ctx, assertRoute, skipRoutes)
}
