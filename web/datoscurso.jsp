<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Curso</title>
        <link href="css/Estilosparatabla.css" rel="stylesheet" type="text/css"/>
        <%!
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_IDcurso;
            String s_codigo;
            String s_nombre;
            String s_horas;
            String s_creditos;
            String s_estado;
            
        %>
    </head>
    <body>
        <%
            try{
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                
                s_accion = request.getParameter("f_accion");
                s_IDcurso = request.getParameter("f_idestudiante");
                
                if(s_accion!=null && s_accion.equals("M1")){
                    consulta = "    select codigo, nombre, horas, creditos, estado  "
                                + " from curso "
                                + " where"
                                + " IDcurso = " + s_IDcurso + "; ";
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {
        %>
        
        <form name="EditarEstudianteForm" action="datoscurso.jsp" method="GET">
            <table border="0" align="center" class="general" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2">Editar Curso</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Codigo: </td>
                        <td><input type="text" name="f_nombre" value="<% out.print(rs.getString(1)); %>" maxlength="5" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Nombre: </td>
                        <td><input type="text" name="f_apellidos" value="<% out.print(rs.getString(2)); %>" maxlength="30" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Horas: </td>
                        <td><input type="text" name="f_dni" value="<% out.print(rs.getString(3)); %>" maxlength="2" size="2"/></td>
                    </tr>
                    <tr>
                        <td>Creditos:</td>
                        <td><input type="text" name="f_codigo" value="<% out.print(rs.getString(4)); %>" maxlength="2" size="2"/></td>
                    </tr>
                    <tr>
                        <td>Estado: </td>
                        <td><input type="text" name="f_estado" value="<% out.print(rs.getString(5)); %>" maxlength="1" size="2"/></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Editar" name="f_editar" />
                            <input type="hidden" name="f_accion" value="M2" />
                            <input type="hidden" name="f_idestudiante" value="<% out.print(s_IDcurso); %>" />
                        </td>
                    </tr>
                </tbody>
            </table>

        </form>
        <%
                }
            }else{
        %>
        <form name="AgregarEstudianteForm" action="datoscurso.jsp" method="GET">
            <table border="0" align="center" class="general" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Curso</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Codigo: </td>
                        <td><input type="text" name="f_nombre" value="" maxlength="5" size="10" /></td>
                    </tr>
                    <tr>
                        <td>Nombre: </td>
                        <td><input type="text" name="f_apellidos" value="" maxlength="30" size="20" /></td>
                    </tr>
                    <tr>
                        <td>Horas: </td>
                        <td><input type="text" name="f_dni" value="" maxlength="2" size="2"/></td>
                    </tr>
                    <tr>
                        <td>Creditos:</td>
                        <td><input type="text" name="f_codigo" value="" maxlength="2" size="2"/></td>
                    </tr>
                    <tr>
                        <td>Estado: </td>
                        <td><input type="text" name="f_estado" value="" maxlength="1" size="2"/></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Agregar" name="f_agregar" />
                            <input type="hidden" name="f_accion" value="C" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <%
        }
        %>
        
        <table border="1" cellspacing="0" cellpadding="" align = "center" class="general" style="margin: auto; display: table">
            <thead>
                <tr>
                    <th colspan="8">Datos Curso</th>
                </tr>
                <tr>
                    <th>N°</th>
                    <th>Codigo</th>
                    <th>Nombre</th>
                    <th>Horas</th>
                    <th>Creditos</th>
                    <th>Estado</th>
                    <th>Eliminar</th>
                    <th>Editar</th>
                </tr>
            </thead>

        <%
            
                
                if (s_accion!=null) {
                    if (s_accion.equals("E")) {
                        consulta =  "   delete from curso "
                                    + " where "
                                    + " IDcurso = " + s_IDcurso + "; ";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                            
                    }else if (s_accion.equals("C")) {
                        s_codigo = request.getParameter("f_nombre");
                        s_nombre = request.getParameter("f_apellidos");
                        s_horas = request.getParameter("f_dni");
                        s_creditos = request.getParameter("f_codigo");
                        s_estado = request.getParameter("f_estado");
                        consulta =  "   insert into "
                                    + " curso(codigo, nombre, horas, creditos, estado) "
                                    + " values ('"+ s_codigo +"','"+ s_nombre +"','"+ s_horas +"','"+ s_creditos +"','"+ s_estado +"')";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }else if (s_accion.equals("M2")) {
                        s_codigo = request.getParameter("f_nombre");
                        s_nombre = request.getParameter("f_apellidos");
                        s_horas = request.getParameter("f_dni");
                        s_creditos = request.getParameter("f_codigo");
                        s_estado = request.getParameter("f_estado");
                        consulta = " update  estudiante  "
                                + "  set  "
                                + "  codigo = '"+ s_codigo +"',"
                                + "  nombre = '"+ s_nombre +"',"
                                + "  horas = '"+ s_horas +"', "
                                + "  creditos = '"+ s_creditos +"', "
                                + "  estado = '"+ s_estado +"' "
                                + "  where "
                                + "  IDcurso = "+ s_IDcurso +"; ";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }
                }
                consulta= " Select IDcurso, codigo, nombre, horas, creditos, estado "
                        + " from curso ";
                //out.print(consulta);
                pst = cn.prepareStatement(consulta);
                rs = pst.executeQuery();
                int num = 0;
                String ide;
                while (rs.next()) {  
                    ide = rs.getString(1);
                    num++;

                    %>
                    <tr>
                        <td><%out.print(num);%></td>
                        <td><%out.print(rs.getString(2));%></td>
                        <td><%out.print(rs.getString(3));%></td>
                        <td><%out.print(rs.getString(4));%></td>
                        <td><%out.print(rs.getString(5));%></td>
                        <td><%out.print(rs.getString(6));%></td>
                        <td><a href="datoscurso.jsp?f_accion=E&f_idestudiante=<%out.print(ide);%>">Eliminar</a></td>
                        <td><a href="datoscurso.jsp?f_accion=M1&f_idestudiante=<%out.print(ide);%>">Editar</a></td>

                    </tr>                    
                    <%
                    }
            }catch(Exception e){
                out.print("Error SQL");
            }
        
        %>
        </table>
    </body>
</html>
