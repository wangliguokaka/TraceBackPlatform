using D2012.Domain.Entities;
using D2012.Domain.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DBTableManagement : System.Web.UI.Page
{
    ServiceCommon servComm = new ServiceCommon();
    protected void Page_Load(object sender, EventArgs e)
    {
        ModelSpec modelSpec = new ModelSpec();
        modelSpec.Class = "A";
        modelSpec.Color = "Black";
        modelSpec.exterior = "exterior";
        modelSpec.Size = "Size";
        modelSpec.OrderNo = "OrderNo";
        modelSpec.Remark = "Remark";
        servComm.Add(modelSpec);
    }
}